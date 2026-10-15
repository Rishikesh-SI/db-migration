-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: khi
-- Object: ix_khi_ad_ad_type
-- Type: INDEX

-- Name: ix_khi_ad_ad_type; Type: INDEX; Schema: khi; Owner: -
--

CREATE INDEX ix_khi_ad_ad_type ON khi.khi_ad USING btree (ad_type);


--
