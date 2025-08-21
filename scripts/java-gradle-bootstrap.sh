#!/usr/bin/env bash
set -euo pipefail

# Create a minimal Gradle project that uses examples/java as the source root
cat > build.gradle <<'EOF'
plugins { id 'application' }

repositories { mavenCentral() }

dependencies {
    implementation 'com.hedera.hashgraph:sdk:2.60.0'
    implementation 'com.google.code.gson:gson:2.11.0'
    implementation 'io.grpc:grpc-netty-shaded:1.61.0'

}

sourceSets {
    main {
        java {
            srcDirs = ['examples/java']
        }
    }
}

application {
    // adjust if your class is in a package
    mainClass = 'CreateAccountDemo'
}
EOF

echo "rootProject.name = 'docs-examples-runner'" > settings.gradle

# Gradle wrapper (works on GitHub runners)
if [ ! -f gradlew ]; then
  curl -sL https://services.gradle.org/distributions/gradle-8.9-bin.zip -o gradle.zip
  mkdir -p .gradle/wrapper/dists
  unzip -q gradle.zip -d .gradle >/dev/null || true
  rm -f gradle.zip
  # Initialize wrapper using the installed gradle if present, else try system gradle
  if command -v gradle >/dev/null 2>&1; then
    gradle wrapper -q
  else
    # Fallback: download wrapper script only (runner usually has Gradle anyway)
    curl -s https://raw.githubusercontent.com/gradle/gradle/master/gradlew -o gradlew
    chmod +x gradlew
  fi
fi

chmod +x gradlew
echo "✅ Gradle bootstrap complete"

