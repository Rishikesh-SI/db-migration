-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labtcs
-- Object: ix_tsk_ad_ad_type
-- Type: INDEX

-- Name: ix_tsk_ad_ad_type; Type: INDEX; Schema: labtcs; Owner: -
--

CREATE INDEX ix_tsk_ad_ad_type ON labtcs.labtcs_ad USING btree (ad_type);


--
