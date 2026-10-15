-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: isl
-- Object: ix_isl_asset_list_title_alias
-- Type: INDEX

-- Name: ix_isl_asset_list_title_alias; Type: INDEX; Schema: isl; Owner: -
--

CREATE INDEX ix_isl_asset_list_title_alias ON isl.isl_asset_list USING btree (title_alias);


--
