shared_examples_for 'a jvm build' do
  it_behaves_like 'a jdk build'

  describe 'if build.gradle exists' do
    before :each do
      file('build.gradle')
    end

    context 'without a gradle wrapper' do
      it 'installs with gradle assemble' do
        should run 'gradle assemble', echo: true, log: true, assert: true
      end

      it 'runs gradle check' do
        should run 'gradle check', echo: true, log: true
      end
    end

    context 'with a gradle wrapper present' do
      before do
        executable('./gradlew')
      end

      it 'installs with ./gradlew assemble' do
        should run './gradlew assemble', echo: true, log: true, assert: true
      end

      it 'runs ./gradlew check' do
        should run './gradlew check', echo: true, log: true
      end
    end
  end

  describe 'if pom.xml exists' do
    before :each do
      file('pom.xml')
    end

    it 'installs with mvn install -DskipTests=true -Dmaven.javadoc.skip=true -B -V' do
      should run 'mvn install -DskipTests=true -Dmaven.javadoc.skip=true -B -V', echo: true, log: true, assert: true
    end

    it 'runs mvn test -B' do
      should run 'mvn test -B', echo: true, log: true
    end
  end

  describe 'if neither gradle nor mvn are used' do
    it 'runs ant test' do
      should run 'ant test', echo: true, log: true
    end
  end

end
