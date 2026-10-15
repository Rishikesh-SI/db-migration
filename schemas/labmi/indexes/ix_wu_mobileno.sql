-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labmi
-- Object: ix_wu_mobileno
-- Type: INDEX

-- Name: ix_wu_mobileno; Type: INDEX; Schema: labmi; Owner: -
--

CREATE INDEX ix_wu_mobileno ON labmi.labmi_web_user USING btree (mobile_no);


--
