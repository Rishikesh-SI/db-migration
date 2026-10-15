-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: upy
-- Object: ix_article_asset_map_aid
-- Type: INDEX

-- Name: ix_article_asset_map_aid; Type: INDEX; Schema: upy; Owner: -
--

CREATE INDEX ix_article_asset_map_aid ON upy.upy_article_asset_map USING btree (article_id);


--
