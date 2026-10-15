-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labilt
-- Object: labilt_custom_web_json d_name_unq
-- Type: CONSTRAINT

-- Name: labilt_custom_web_json d_name_unq; Type: CONSTRAINT; Schema: labilt; Owner: -
--

ALTER TABLE ONLY labilt.labilt_custom_web_json
    ADD CONSTRAINT d_name_unq UNIQUE (student_id, school_name, module_name);


--
