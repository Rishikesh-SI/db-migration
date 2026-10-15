-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: ttgl
-- Object: ix_ttgl_article_asset_map_aid
-- Type: INDEX

-- Name: ix_ttgl_article_asset_map_aid; Type: INDEX; Schema: ttgl; Owner: -
--

CREATE INDEX ix_ttgl_article_asset_map_aid ON ttgl.ttgl_article_asset_map USING btree (article_id);


--
