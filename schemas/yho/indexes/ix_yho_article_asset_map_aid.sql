-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: yho
-- Object: ix_yho_article_asset_map_aid
-- Type: INDEX

-- Name: ix_yho_article_asset_map_aid; Type: INDEX; Schema: yho; Owner: -
--

CREATE INDEX ix_yho_article_asset_map_aid ON yho.yho_article_asset_map USING btree (article_id);


--
