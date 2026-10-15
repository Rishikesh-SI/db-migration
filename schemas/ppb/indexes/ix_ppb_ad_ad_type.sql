-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: ppb
-- Object: ix_ppb_ad_ad_type
-- Type: INDEX

-- Name: ix_ppb_ad_ad_type; Type: INDEX; Schema: ppb; Owner: -
--

CREATE INDEX ix_ppb_ad_ad_type ON ppb.ppb_ad USING btree (ad_type);


--
