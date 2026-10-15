-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: pkl
-- Object: wf_user_upper_email_id_ix
-- Type: INDEX

-- Name: wf_user_upper_email_id_ix; Type: INDEX; Schema: pkl; Owner: -
--

CREATE UNIQUE INDEX wf_user_upper_email_id_ix ON pkl.wf_user_custom USING btree (upper_email_id);


--
