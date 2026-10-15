-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labpkl
-- Object: ix_pkl_asset_list_title_alias
-- Type: INDEX

-- Name: ix_pkl_asset_list_title_alias; Type: INDEX; Schema: labpkl; Owner: -
--

CREATE INDEX ix_pkl_asset_list_title_alias ON labpkl.labpkl_asset_list USING btree (title_alias);


--
