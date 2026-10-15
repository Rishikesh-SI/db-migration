-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labpbl
-- Object: ix_pkl_user_emailid
-- Type: INDEX

-- Name: ix_pkl_user_emailid; Type: INDEX; Schema: labpbl; Owner: -
--

CREATE INDEX ix_pkl_user_emailid ON labpbl.labpbl_user USING btree (email_id);


--
