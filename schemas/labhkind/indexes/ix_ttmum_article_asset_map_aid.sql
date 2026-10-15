-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labhkind
-- Object: ix_ttmum_article_asset_map_aid
-- Type: INDEX

-- Name: ix_ttmum_article_asset_map_aid; Type: INDEX; Schema: labhkind; Owner: -
--

CREATE INDEX ix_ttmum_article_asset_map_aid ON labhkind.labhkind_article_asset_map USING btree (article_id);


--
