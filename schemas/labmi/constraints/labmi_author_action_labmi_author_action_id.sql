-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labmi
-- Object: labmi_author_action labmi_author_action_id
-- Type: CONSTRAINT

-- Name: labmi_author_action labmi_author_action_id; Type: CONSTRAINT; Schema: labmi; Owner: -
--

ALTER TABLE ONLY labmi.labmi_author_action
    ADD CONSTRAINT labmi_author_action_id PRIMARY KEY (author_action_id);


--
