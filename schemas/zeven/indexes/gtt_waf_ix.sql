-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: zeven
-- Object: gtt_waf_ix
-- Type: INDEX

-- Name: gtt_waf_ix; Type: INDEX; Schema: zeven; Owner: -
--

CREATE INDEX gtt_waf_ix ON zeven.gtt_waf USING btree (col1_seqid, col2_number, col3_number, col4_number);


--
