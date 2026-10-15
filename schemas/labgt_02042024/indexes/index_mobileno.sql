-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labgt_02042024
-- Object: index_mobileno
-- Type: INDEX

-- Name: index_mobileno; Type: INDEX; Schema: labgt_02042024; Owner: -
--

CREATE INDEX index_mobileno ON labgt_02042024.labgt_web_user USING btree (mobile_no);


--
