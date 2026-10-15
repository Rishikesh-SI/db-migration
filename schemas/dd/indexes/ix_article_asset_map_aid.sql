-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: dd
-- Object: ix_article_asset_map_aid
-- Type: INDEX

-- Name: ix_article_asset_map_aid; Type: INDEX; Schema: dd; Owner: -
--

CREATE INDEX ix_article_asset_map_aid ON dd.dd_article_asset_map USING btree (article_id);


--
