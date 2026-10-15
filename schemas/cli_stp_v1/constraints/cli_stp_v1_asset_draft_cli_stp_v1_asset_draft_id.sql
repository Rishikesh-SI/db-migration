-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: cli_stp_v1
-- Object: cli_stp_v1_asset_draft cli_stp_v1_asset_draft_id
-- Type: CONSTRAINT

-- Name: cli_stp_v1_asset_draft cli_stp_v1_asset_draft_id; Type: CONSTRAINT; Schema: cli_stp_v1; Owner: -
--

ALTER TABLE ONLY cli_stp_v1.cli_stp_v1_asset_draft
    ADD CONSTRAINT cli_stp_v1_asset_draft_id PRIMARY KEY (asset_draft_id);


--
