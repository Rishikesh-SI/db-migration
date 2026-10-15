-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labstlz
-- Object: ix_kxp_asset_list_title_alias
-- Type: INDEX

-- Name: ix_kxp_asset_list_title_alias; Type: INDEX; Schema: labstlz; Owner: -
--

CREATE INDEX ix_kxp_asset_list_title_alias ON labstlz.labstlz_asset_list USING btree (title_alias);


--
