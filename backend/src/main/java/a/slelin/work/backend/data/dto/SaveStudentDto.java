package a.slelin.work.backend.data.dto;

import lombok.Builder;

@Builder
public record SaveStudentDto(String name,
                             String surname,
                             String middleName,
                             Long cardNumber,
                             String faculty,
                             String department,
                             String studyGroup,
                             String email,
                             String phone) implements SaveDto {
}
