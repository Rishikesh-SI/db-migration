-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: yho
-- Object: ix_yho_ad_ad_type
-- Type: INDEX

-- Name: ix_yho_ad_ad_type; Type: INDEX; Schema: yho; Owner: -
--

CREATE INDEX ix_yho_ad_ad_type ON yho.yho_ad USING btree (ad_type);


--
