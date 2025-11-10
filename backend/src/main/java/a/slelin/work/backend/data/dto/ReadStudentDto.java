package a.slelin.work.backend.data.dto;

import lombok.Builder;

@Builder
public record ReadStudentDto(String id,
                             String name,
                             String surname,
                             String middleName,
                             Long cardNumber,
                             String faculty,
                             String department,
                             String studyGroup,
                             String email,
                             String phone) implements ReadDto {
}
