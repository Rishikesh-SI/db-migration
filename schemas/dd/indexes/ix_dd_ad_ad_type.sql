-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: dd
-- Object: ix_dd_ad_ad_type
-- Type: INDEX

-- Name: ix_dd_ad_ad_type; Type: INDEX; Schema: dd; Owner: -
--

CREATE INDEX ix_dd_ad_ad_type ON dd.dd_ad USING btree (ad_type);


--
