-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labmi_v1
-- Object: labmi_v1_author_action labmi_v1_author_action_id
-- Type: CONSTRAINT

-- Name: labmi_v1_author_action labmi_v1_author_action_id; Type: CONSTRAINT; Schema: labmi_v1; Owner: -
--

ALTER TABLE ONLY labmi_v1.labmi_v1_author_action
    ADD CONSTRAINT labmi_v1_author_action_id PRIMARY KEY (author_action_id);


--
