-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labhsl
-- Object: ix_hsl_article_asset_map_aid
-- Type: INDEX

-- Name: ix_hsl_article_asset_map_aid; Type: INDEX; Schema: labhsl; Owner: -
--

CREATE INDEX ix_hsl_article_asset_map_aid ON labhsl.labhsl_article_asset_map USING btree (article_id);


--
