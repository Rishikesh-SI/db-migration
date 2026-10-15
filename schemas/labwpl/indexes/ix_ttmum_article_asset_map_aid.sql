-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labwpl
-- Object: ix_ttmum_article_asset_map_aid
-- Type: INDEX

-- Name: ix_ttmum_article_asset_map_aid; Type: INDEX; Schema: labwpl; Owner: -
--

CREATE INDEX ix_ttmum_article_asset_map_aid ON labwpl.labwpl_article_asset_map USING btree (article_id);


--
