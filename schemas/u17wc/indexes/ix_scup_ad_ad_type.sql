-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: u17wc
-- Object: ix_scup_ad_ad_type
-- Type: INDEX

-- Name: ix_scup_ad_ad_type; Type: INDEX; Schema: u17wc; Owner: -
--

CREATE INDEX ix_scup_ad_ad_type ON u17wc.u17wc_ad USING btree (ad_type);


--
