-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: zeven
-- Object: ix_zeven_ad_ad_type
-- Type: INDEX

-- Name: ix_zeven_ad_ad_type; Type: INDEX; Schema: zeven; Owner: -
--

CREATE INDEX ix_zeven_ad_ad_type ON zeven.zeven_ad USING btree (ad_type);


--
