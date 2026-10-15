-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: cli_stp_v1
-- Object: ix_ttmum_asset_list_title_alias
-- Type: INDEX

-- Name: ix_ttmum_asset_list_title_alias; Type: INDEX; Schema: cli_stp_v1; Owner: -
--

CREATE INDEX ix_ttmum_asset_list_title_alias ON cli_stp_v1.cli_stp_v1_asset_list USING btree (title_alias);


--
