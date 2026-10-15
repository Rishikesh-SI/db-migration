-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labmi_beta_22042024
-- Object: labmi_gallery unique_gallery_name
-- Type: CONSTRAINT

-- Name: labmi_gallery unique_gallery_name; Type: CONSTRAINT; Schema: labmi_beta_22042024; Owner: -
--

ALTER TABLE ONLY labmi_beta_22042024.labmi_gallery
    ADD CONSTRAINT unique_gallery_name UNIQUE (gallery_name);


--
