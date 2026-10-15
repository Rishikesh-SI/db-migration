-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: swa
-- Object: ix_article_asset_map_aid
-- Type: INDEX

-- Name: ix_article_asset_map_aid; Type: INDEX; Schema: swa; Owner: -
--

CREATE INDEX ix_article_asset_map_aid ON swa.swa_article_asset_map USING btree (article_id);


--
