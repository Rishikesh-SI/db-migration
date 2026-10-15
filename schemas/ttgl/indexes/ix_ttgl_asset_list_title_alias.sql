-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: ttgl
-- Object: ix_ttgl_asset_list_title_alias
-- Type: INDEX

-- Name: ix_ttgl_asset_list_title_alias; Type: INDEX; Schema: ttgl; Owner: -
--

CREATE INDEX ix_ttgl_asset_list_title_alias ON ttgl.ttgl_asset_list USING btree (title_alias);


--
