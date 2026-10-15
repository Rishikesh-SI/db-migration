-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: kxp
-- Object: ix_kxp_ad_ad_type
-- Type: INDEX

-- Name: ix_kxp_ad_ad_type; Type: INDEX; Schema: kxp; Owner: -
--

CREATE INDEX ix_kxp_ad_ad_type ON kxp.kxp_ad USING btree (ad_type);


--
