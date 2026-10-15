-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: fanxp_wf
-- Object: labwf_user_email_id_idx
-- Type: INDEX

-- Name: labwf_user_email_id_idx; Type: INDEX; Schema: fanxp_wf; Owner: -
--

CREATE INDEX labwf_user_email_id_idx ON fanxp_wf.labwf_user USING btree (email_id);


--
