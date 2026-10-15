-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: scom
-- Object: ix_scom_ad_ad_type
-- Type: INDEX

-- Name: ix_scom_ad_ad_type; Type: INDEX; Schema: scom; Owner: -
--

CREATE INDEX ix_scom_ad_ad_type ON scom.scom_ad USING btree (ad_type);


--
