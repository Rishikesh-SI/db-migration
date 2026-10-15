-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labrao
-- Object: ix_ttmum_article_asset_map_aid
-- Type: INDEX

-- Name: ix_ttmum_article_asset_map_aid; Type: INDEX; Schema: labrao; Owner: -
--

CREATE INDEX ix_ttmum_article_asset_map_aid ON labrao.labrao_article_asset_map USING btree (article_id);


--
