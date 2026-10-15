-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labtri
-- Object: labtri_author_action labtri_author_action_id
-- Type: CONSTRAINT

-- Name: labtri_author_action labtri_author_action_id; Type: CONSTRAINT; Schema: labtri; Owner: -
--

ALTER TABLE ONLY labtri.labtri_author_action
    ADD CONSTRAINT labtri_author_action_id PRIMARY KEY (author_action_id);


--
