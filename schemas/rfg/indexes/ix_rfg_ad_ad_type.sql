-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: rfg
-- Object: ix_rfg_ad_ad_type
-- Type: INDEX

-- Name: ix_rfg_ad_ad_type; Type: INDEX; Schema: rfg; Owner: -
--

CREATE INDEX ix_rfg_ad_ad_type ON rfg.rfg_ad USING btree (ad_type);


--
