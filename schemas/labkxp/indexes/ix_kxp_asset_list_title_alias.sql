-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labkxp
-- Object: ix_kxp_asset_list_title_alias
-- Type: INDEX

-- Name: ix_kxp_asset_list_title_alias; Type: INDEX; Schema: labkxp; Owner: -
--

CREATE INDEX ix_kxp_asset_list_title_alias ON labkxp.labkxp_asset_list USING btree (title_alias);


--
