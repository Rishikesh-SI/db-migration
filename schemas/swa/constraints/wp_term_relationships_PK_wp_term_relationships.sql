-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: swa
-- Object: wp_term_relationships PK_wp_term_relationships
-- Type: CONSTRAINT

-- Name: wp_term_relationships PK_wp_term_relationships; Type: CONSTRAINT; Schema: swa; Owner: -
--

ALTER TABLE ONLY swa.wp_term_relationships
    ADD CONSTRAINT "PK_wp_term_relationships" PRIMARY KEY (object_id, term_taxonomy_id);


--
