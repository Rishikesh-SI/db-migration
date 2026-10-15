-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: dd
-- Object: index_mobileno
-- Type: INDEX

-- Name: index_mobileno; Type: INDEX; Schema: dd; Owner: -
--

CREATE INDEX index_mobileno ON dd.dd_web_user USING btree (mobile_no);


--
