-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labkc_v1
-- Object: index_mobileno
-- Type: INDEX

-- Name: index_mobileno; Type: INDEX; Schema: labkc_v1; Owner: -
--

CREATE INDEX index_mobileno ON labkc_v1.labkc_v1_web_user USING btree (mobile_no);


--
