-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: scom
-- Object: ix_article_asset_map_aid
-- Type: INDEX

-- Name: ix_article_asset_map_aid; Type: INDEX; Schema: scom; Owner: -
--

CREATE INDEX ix_article_asset_map_aid ON scom.scom_article_asset_map USING btree (article_id);


--
