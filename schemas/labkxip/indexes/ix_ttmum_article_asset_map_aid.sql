-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labkxip
-- Object: ix_ttmum_article_asset_map_aid
-- Type: INDEX

-- Name: ix_ttmum_article_asset_map_aid; Type: INDEX; Schema: labkxip; Owner: -
--

CREATE INDEX ix_ttmum_article_asset_map_aid ON labkxip.labkxip_article_asset_map USING btree (article_id);


--
