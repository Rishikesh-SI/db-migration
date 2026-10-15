-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labmao
-- Object: ix_ttmum_article_asset_map_aid
-- Type: INDEX

-- Name: ix_ttmum_article_asset_map_aid; Type: INDEX; Schema: labmao; Owner: -
--

CREATE INDEX ix_ttmum_article_asset_map_aid ON labmao.labmao_article_asset_map USING btree (article_id);


--
