-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: ttgl
-- Object: ix_ttgl_asset_list_published_date
-- Type: INDEX

-- Name: ix_ttgl_asset_list_published_date; Type: INDEX; Schema: ttgl; Owner: -
--

CREATE INDEX ix_ttgl_asset_list_published_date ON ttgl.ttgl_asset_list USING btree (published_date);


--
