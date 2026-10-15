-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labdv
-- Object: ix_ttmum_article_asset_map_aid
-- Type: INDEX

-- Name: ix_ttmum_article_asset_map_aid; Type: INDEX; Schema: labdv; Owner: -
--

CREATE INDEX ix_ttmum_article_asset_map_aid ON labdv.labdv_article_asset_map USING btree (article_id);


--
