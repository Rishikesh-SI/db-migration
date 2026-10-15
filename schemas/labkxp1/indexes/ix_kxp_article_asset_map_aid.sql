-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labkxp1
-- Object: ix_kxp_article_asset_map_aid
-- Type: INDEX

-- Name: ix_kxp_article_asset_map_aid; Type: INDEX; Schema: labkxp1; Owner: -
--

CREATE INDEX ix_kxp_article_asset_map_aid ON labkxp1.labkxp_article_asset_map USING btree (article_id);


--
