-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: dd_30_04_24
-- Object: ix_dd_ad_ad_type
-- Type: INDEX

-- Name: ix_dd_ad_ad_type; Type: INDEX; Schema: dd_30_04_24; Owner: -
--

CREATE INDEX ix_dd_ad_ad_type ON dd_30_04_24.dd_ad USING btree (ad_type);


--
