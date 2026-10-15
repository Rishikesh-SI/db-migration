-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: pbl
-- Object: ix_pbl_ad_ad_type
-- Type: INDEX

-- Name: ix_pbl_ad_ad_type; Type: INDEX; Schema: pbl; Owner: -
--

CREATE INDEX ix_pbl_ad_ad_type ON pbl.pbl_ad USING btree (ad_type);


--
