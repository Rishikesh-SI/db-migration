-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labrr
-- Object: index_mobileno
-- Type: INDEX

-- Name: index_mobileno; Type: INDEX; Schema: labrr; Owner: -
--

CREATE INDEX index_mobileno ON labrr.labrr_web_user USING btree (mobile_no);


--
