-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labpkl_v1
-- Object: wf_user_upper_email_id_ix
-- Type: INDEX

-- Name: wf_user_upper_email_id_ix; Type: INDEX; Schema: labpkl_v1; Owner: -
--

CREATE UNIQUE INDEX wf_user_upper_email_id_ix ON labpkl_v1.wf_user_custom USING btree (upper_email_id);


--
