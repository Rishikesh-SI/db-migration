-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labgt_02042024
-- Object: labgt_web_user unique_equip_id
-- Type: CONSTRAINT

-- Name: labgt_web_user unique_equip_id; Type: CONSTRAINT; Schema: labgt_02042024; Owner: -
--

ALTER TABLE ONLY labgt_02042024.labgt_web_user
    ADD CONSTRAINT unique_equip_id UNIQUE (mobile_no);


--
