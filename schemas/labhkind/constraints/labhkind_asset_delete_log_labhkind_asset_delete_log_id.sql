-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labhkind
-- Object: labhkind_asset_delete_log labhkind_asset_delete_log_id
-- Type: CONSTRAINT

-- Name: labhkind_asset_delete_log labhkind_asset_delete_log_id; Type: CONSTRAINT; Schema: labhkind; Owner: -
--

ALTER TABLE ONLY labhkind.labhkind_asset_delete_log
    ADD CONSTRAINT labhkind_asset_delete_log_id PRIMARY KEY (asset_delete_log_id);


--
